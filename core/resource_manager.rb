# core/resource_manager.rb
require 'singleton'

class ResourceManager
  include Singleton

  def initialize
    @sounds = { shoot: Sound.new('shoot.wav'), jump: Sound.new('jump.wav') }
    @textures = { player: Image.new('player.png') }
  end

  def get_sound(key) = @sounds[key]
  def get_texture(key) = @textures[key]
end