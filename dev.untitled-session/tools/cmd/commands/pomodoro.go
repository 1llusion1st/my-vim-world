package commands

import "fmt"

type PomodoroCmd struct {
}

func (p *PomodoroCmd) Run(ctx *Context) error {
	app := NewEventLoopHandler(nil, nil, nil)

	appPtr := &app
	fmt.Printf("app ptr(e): %p\n", appPtr)

	err := appPtr.Run()
	if err != nil {
		fmt.Println("err got: ", err)
	}

	return nil
}
