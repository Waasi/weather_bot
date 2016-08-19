# WeatherBot

WeatherBot allows users to easily incorporate weather
bots to your slack teams. WeatherBot uses the Apixu API
via the [Juracan Modules](https://github.com/Waasi/juracan)

## Installation

  1. Clone the repository
  2. Run ```shell mix deps.get```
  3. Run ```shell mix ecto.migrate```
  4. Run ```shell mix phoenix.server```

  Remember to start the PostgreSQL Server and to configure
  the Environment for [Juracan](https://github.com/Waasi/juracan)

## Configuration

  Once WeatherBot is up and running:

    1. Visit Slack and start creating a Slash Command
    1. Visit your Weather Bot instance and add your Slack WeatherBot.
    2. Configure your url for the slash command in Slack
    3. Save your slack slash command configuration

## Live Demo

To see how it works use the [Live Demo Instance](https://weatherbots.herokuapp.com)

