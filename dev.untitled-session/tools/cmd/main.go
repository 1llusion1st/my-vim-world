package main

import (
	"tools/cmd/commands"

	"github.com/alecthomas/kong"
)

var cli struct {
	Pomodoro commands.PomodoroCmd `cmd:"" help:"run pomodoro app"`
}

func main() {
	ctx := kong.Parse(&cli)
	err := ctx.Run(&commands.Context{})
	ctx.FatalIfErrorf(err)
}
