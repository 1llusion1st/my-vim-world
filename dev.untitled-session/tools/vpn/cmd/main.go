package main

import (
	"context"
	"fmt"
	"os"
	"strings"
	"time"
	"tools/vpn"

	"github.com/charmbracelet/bubbles/timer"
	tea "github.com/charmbracelet/bubbletea"
)

func main() {
	dir := "dev/vpns"
	if len(os.Args) == 2 {
		dir = os.Args[1]
	}
	vpns, err := vpn.ReadConfiguration(context.Background(), dir)
	if err != nil {
		panic(err)
	}
	p := tea.NewProgram(initialModel(vpns), tea.WithAltScreen())
	if _, err := p.Run(); err != nil {
		fmt.Printf("Alas, there's been an error: %v", err)
		os.Exit(1)
	}

}

func initialModel(vpns *vpn.VPNsConfig) model {
	return model{
		timer:  timer.NewWithInterval(999999999*time.Second, 100*time.Millisecond),
		vpns:   vpns,
		index:  0,
		status: make(map[int]string),
	}
}

type model struct {
	vpns   *vpn.VPNsConfig
	index  int
	status map[int]string
	timer  timer.Model
}

// Init is the first function that will be called. It returns an optional
// initial command. To not perform an initial command return nil.
func (m model) Init() tea.Cmd {
	m.timer.Timeout = time.Second

	return m.timer.Init()
}

// Update is called when a message is received. Use it to inspect messages
// and, in response, update the model and/or send a command.
func (m model) Update(msg_ tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg_.(type) {
	case timer.StartStopMsg:
		var cmd tea.Cmd
		m.timer, cmd = m.timer.Update(msg)
		return m, cmd
	case timer.TimeoutMsg:
		m.timer, _ = m.timer.Update(msg)

		return m, m.timer.Start()
	case timer.TickMsg:
		var cmd tea.Cmd
		m.timer, cmd = m.timer.Update(msg)

		m = m.UpdateStatuses()

		return m, cmd
	case tea.KeyMsg:
		{
			switch msg.String() {
			case "ctrl+c":
				{
					for _, vpn := range m.vpns.VPNs {
						if vpn.Active() {
							vpn.Down(context.Background())
						}
					}
					return m, tea.Quit
				}
			case "up", "k":
				{
					if m.index > 0 {
						m.index -= 1
					}
				}
			case "down", "j":
				{
					if m.index < len(m.vpns.VPNs)-1 {
						m.index += 1
					}
				}
			case "enter", " ":
				{
					if m.vpns.VPNs[m.index].Active() {
						m.vpns.VPNs[m.index].Down(context.Background())
					} else {
						m.vpns.VPNs[m.index].Up(context.Background())
						go m.vpns.VPNs[m.index].HandleRestart(context.Background())
					}

					m.status[m.index] = m.vpns.VPNs[m.index].GetSym()
				}
			}
		}
	}

	return m, nil
}

func (m model) UpdateStatuses() model {
	for i := range m.status {
		m.status[i] = m.vpns.VPNs[i].GetSym()
	}

	return m
}

// View renders the program's UI, which is just a string. The view is
// rendered after every Update.
func (m model) View() string {
	lines := make([]string, 0)
	lines = append(lines, "VPNS:")
	for i, vpn := range m.vpns.VPNs {
		current := m.index == i
		prefix := " "
		if current {
			prefix = ">"
		}

		line := fmt.Sprintf("%s %s ", prefix, vpn.GetSym())

		line = line + vpn.Name
		lines = append(lines, line)
	}
	return strings.Join(lines, "\n")
}
