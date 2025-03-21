class CollisionManager
  def self.check_projectile_collisions(projectiles, targets)
    projectiles.each do |projectile|
      targets.each do |target|
        if collides?(projectile, target)

          projectile.destroy
          break
        end
      end
    end
  end

  def self.collides?(projectile, target)
    target.sprite.contains?(projectile.sprite.x, projectile.sprite.y)
  end
end