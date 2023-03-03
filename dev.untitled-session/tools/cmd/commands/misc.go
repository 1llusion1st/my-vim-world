package commands

import (
	"fmt"
	"sync"
	"time"

	"github.com/nsf/termbox-go"
)

func NewEventLoopHandler(uiHandler UIDrawFunc, commandHandler CommandFunc, specSymbolHandler EventSpecialSymbolHandlerFunc) EventLoopHandler {
	res := EventLoopHandler{
		break_:             rune('C'),
		updateIntervalMSec: 100,
		inputChan:          make(chan string),
		mode:               0,
		errChan:            make(chan error),
		doneChan:           make(chan bool),

		drawHandler:            uiHandler,
		eventSpecSymbolHandler: specSymbolHandler,
		commandHandler:         commandHandler,
	}
	if uiHandler == nil {
		res.drawHandler = res.defaultUIHandler
	}
	if commandHandler == nil {
		res.commandHandler = res.defaultCommandHandler
	}
	if specSymbolHandler == nil {
		res.eventSpecSymbolHandler = res.defaultSpecSymbolHandler
	}
	return res
}

// handler to process special characters eg. Ctrl+C .. Ctrl+B ...
type EventSpecialSymbolHandlerFunc func(e *EventLoopHandler, symbol string) error

// handler to draw UI
type UIDrawFunc func(e *EventLoopHandler, data interface{}) error

// handler for commands
type CommandFunc func(e *EventLoopHandler, command string) error

type EventLoopHandler struct {
	break_             rune
	updateIntervalMSec int64

	// accumulates printable runes until enter pressed
	buffer string
	// receives inputs from ioLoop func
	inputChan  chan string
	bufferLock sync.Mutex

	// can have some modes
	mode int

	errChan  chan error
	doneChan chan bool

	// handlers
	drawHandler            UIDrawFunc
	eventSpecSymbolHandler EventSpecialSymbolHandlerFunc
	commandHandler         CommandFunc
}

func (e *EventLoopHandler) Run() error {
	err := termbox.Init()
	if err != nil {
		return err
	}
	defer termbox.Close()

	go e.ioLoop()
	return e.mainLoop()
}

func (e *EventLoopHandler) Terminate() error {
	e.doneChan <- true
	return nil
}

func (e *EventLoopHandler) GetMode() int {
	return e.mode
}

func (e *EventLoopHandler) GetBuffer() string {
	e.bufferLock.Lock()
	defer e.bufferLock.Unlock()
	return e.buffer
}

func (e *EventLoopHandler) SetMode(mode int) *EventLoopHandler {
	e.mode = mode
	return e
}

func (e *EventLoopHandler) SetUIHandler(f UIDrawFunc) *EventLoopHandler {
	e.drawHandler = f
	return e
}

func (e *EventLoopHandler) SetSpecSymbolHandler(f EventSpecialSymbolHandlerFunc) *EventLoopHandler {
	e.eventSpecSymbolHandler = f
	return e
}

func (e *EventLoopHandler) SetCommandHandler(f CommandFunc) *EventLoopHandler {
	e.commandHandler = f
	return e
}

func (e *EventLoopHandler) ioLoop() {

	fmt.Printf("e ptr2: %p\n", e)
	fmt.Printf("buf ptr2: %p\n", &e.buffer)
	for {

		switch ev := termbox.PollEvent(); ev.Type {
		case termbox.EventKey:
			switch ev.Key {
			case termbox.KeyEsc:
				e.doneChan <- true
				return
			case termbox.KeyF1:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "f1")
				}
			case termbox.KeyF2:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "f2")
				}
			case termbox.KeyF3:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "f3")
				}
			case termbox.KeyF4:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "f4")
				}
			case termbox.KeyF5:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "f5")
				}
			case termbox.KeyF6:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "f6")
				}
			case termbox.KeyF7:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "f7")
				}
			case termbox.KeyF8:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "f8")
				}
			case termbox.KeyF9:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "f9")
				}
			case termbox.KeyF10:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "f10")
				}
			case termbox.KeyF11:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "f11")
				}
			case termbox.KeyF12:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "f12")
				}
			case termbox.KeyInsert:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "ins")
				}
			case termbox.KeyDelete:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "del")
				}
			case termbox.KeyHome:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "home")
				}
			case termbox.KeyEnd:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "end")
				}
			case termbox.KeyPgup:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "pgup")
				}
			case termbox.KeyPgdn:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "pgdown")
				}
			case termbox.KeyArrowUp:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "up")
				}
			case termbox.KeyArrowDown:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "down")
				}
			case termbox.KeyArrowLeft:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "left")
				}
			case termbox.KeyArrowRight:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "right")
				}
			case termbox.KeySpace:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "space")
				}
			case termbox.KeyBackspace:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "backspace")
				}
			case termbox.KeyTab:
				{
					termbox.Sync()
					e.eventSpecSymbolHandler(e, "tab")
				}
			case termbox.KeyEnter:
				{
					termbox.Sync()
					e.bufferLock.Lock()
					e.bufferLock.Unlock()

					e.inputChan <- e.buffer
					e.buffer = ""

					e.drawHandler(e, nil)
				}
			default:
				{
					termbox.Sync()
					e.bufferLock.Lock()
					char := ev.Ch

					fmt.Println("symbol pressed: ", string(char))
					e.buffer = e.buffer + string(char)
					fmt.Println("updated buffer(", &e.buffer, "): ", e.buffer)
					e.bufferLock.Unlock()
					e.drawHandler(e, nil)

				}
			}
		case termbox.EventError:
			e.errChan <- ev.Err
			return
		}

	}
}

func (e *EventLoopHandler) mainLoop() error {
	fmt.Printf("e.mainLoop ptr2: %p\n", e)
	fmt.Printf("e.mainLoop buf ptr2: %p\n", &e.buffer)
	for {
		select {
		case err := <-e.errChan:
			{
				return err
			}
		case command := <-e.inputChan:
			{
				err := e.commandHandler(e, command)
				if err != nil {
					return err
				}
				break
			}
		case <-e.doneChan:
			{
				return nil
			}
		case <-time.After(time.Duration(e.updateIntervalMSec) * time.Millisecond):
			{
				e.drawHandler(e, nil)
				continue
			}
		}
	}
}

func (e *EventLoopHandler) defaultUIHandler(eP *EventLoopHandler, data interface{}) error {
	eP.bufferLock.Lock()
	defer eP.bufferLock.Unlock()
	fmt.Println("drawing UI .... buffer(", &eP.buffer, ") is ...", eP.buffer, "mode is: ", eP.mode)
	return nil
}

func (e *EventLoopHandler) defaultSpecSymbolHandler(eP *EventLoopHandler, spec string) error {
	fmt.Println("spec symbol entered: ", spec)
	return nil
}

func (e *EventLoopHandler) defaultCommandHandler(eP *EventLoopHandler, command string) error {
	fmt.Println("You entered command: ", command)
	return nil
}
