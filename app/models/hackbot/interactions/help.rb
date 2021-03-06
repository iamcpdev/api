# frozen_string_literal: true

module Hackbot
  module Interactions
    class Help < Command
      TRIGGER = /help/

      USAGE = 'help'
      DESCRIPTION = 'list available commands'

      def start
        sorted_cmds = cmds.sort_by { |a| a[:usage] }

        msg_channel copy('help', commands: sorted_cmds,
                                 bot_mention: '@' + team.bot_username)
      end

      private

      def cmds
        Command.descendants.map do |c|
          usage = c.usage(event, team)
          desc = c.description(event, team)

          next unless usage && desc

          { usage: usage, desc: desc }
        end.compact
      end
    end
  end
end
