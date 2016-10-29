# Sets accessible battle net configuration and authenticates our battle.net library.
# https://github.com/wingyu/rbattlenet
Rails.application.config.battle_net = Rails.application.config_for(:config)['battle_net']
RBattlenet.authenticate(api_key: Rails.configuration.battle_net['api_key'])