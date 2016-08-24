require "collisions"

local power = {}
power.__index = power

function newPower(object)
	local n = object
	n.stance = "normal"
	n.width = 16
	n.height = 16

	n.imgs = {}
	n.imgs[1] = lutro.graphics.newImage("assets/vampirecanine.png")
	n.imgs[2] = lutro.graphics.newImage("assets/potion.png")
	n.imgs[3] = lutro.graphics.newImage("assets/heart.png")
	n.imgs[4] = lutro.graphics.newImage("assets/catleg.png")

	n.index = math.random(#n.imgs)
	n.t = 0

	return setmetatable(n, power)
end

function power:update(dt)
	self.t = self.t + 0.2
end

function power:draw()
	lutro.graphics.draw(self.imgs[self.index], self.x, self.y + math.cos(self.t))
end

function power:on_collide(e1, e2, dx, dy)
	if compat then
		JOY_DOWN = lutro.input.joypad("down")
	else
		JOY_DOWN = lutro.keyboard.isDown("down")
	end

	if e2.type == "character" and JOY_DOWN then
		lutro.audio.play(sfx_power)

		if self.index == 3 then
			e2.maxhp = e2.maxhp + 1
			e2.hp = e2.hp + 1
			lutro.audio.play(sfx_heart)
		end

		for i=1, #entities do
			if entities[i] == self then
				table.remove(entities, i)
			end
		end
	end
end