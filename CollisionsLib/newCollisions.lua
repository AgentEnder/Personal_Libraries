function newCollisions(obj, dt)
	checkTiles(obj)
	tileResponse(obj, dt)
	if obj == player1 then oPlayer = player2 end
	if obj == player2 then oPlayer = player1 end
	if obj == player1 then oPlayer = player2 elseif player == player2 then oPlayer = player1 end --other Player setup
	if obj.y < oPlayer.y+16 and obj.y - 16 > oPlayer.y - 26 then
		if obj.x + 8 > oPlayer.x - 8 then
			if obj.x + 8 < oPlayer.x + 8 then
				obj.x = obj.x - 101*dt
			end
		end
		if obj.x - 8 < oPlayer.x + 8 then
			if obj.x - 8 > oPlayer.x - 8 then
				obj.x = obj.x + 101*dt
			end
		end
	end
end

function checkTiles(obj)
	local collision = {left = false, right = false, bottom = false, top = false}
	--left side
	for k, v in pairs(tiles) do
		if insideBox(obj.x-1,obj.y+1,v.x,v.y,v.w,v.h) or insideBox(obj.x-1,obj.y+(obj.width-1),v.x,v.y, v.w, v.h) or insideBox(obj.x-1,obj.y+(obj.width/2),v.x,v.y,v.w,v.h) then
			collision.left = true
		--	print("left:" .. v.string)
		end
	--right side
		if insideBox(obj.x+obj.width+1,obj.y+1,v.x,v.y, v.w,v.h) or insideBox(obj.x+obj.width+1,obj.y+(obj.width - 1),v.x,v.y, v.w, v.h) or insideBox(obj.x+obj.width+1,obj.y+(obj.width/2),v.x,v.y, v.w,v.h)then
			collision.right = true
		--	print("right:" .. v.string)
		end
	--bottom
		if insideBox(obj.x+(obj.width-2),obj.y+obj.width+1,v.x,v.y, v.w, v.h) or insideBox(obj.x+2,obj.y+obj.width+1,v.x,v.y, v.w, v.h) or insideBox(obj.x+(obj.width/2),obj.y+obj.width+1,v.x,v.y, v.w, v.h) then
			collision.bottom = true
			if v.string == "Rainbow Platform" then
				obj.health = obj.maxhealth
			end
		--	print(v.string)
		end
	--top
		if insideBox(obj.x+(obj.width-2),obj.y-1,v.x,v.y,v.w,v.h) or insideBox(obj.x+2,obj.y-1,v.x,v.y, v.w, v.h) then
			collision.top = true
		--	print("top")
		end
	end
	--returns
	obj.collisions.left = collision.left
	obj.collisions.right = collision.right
	obj.collisions.top = collision.top
	obj.collisions.bottom = collision.bottom
end

function tileResponse(obj,dt)
	for k, v in pairs(tiles) do
		if v.special ~= nil then
		--	print(v.string)
		end
	end
	if obj.collisions.left == true then obj.x = obj.x + 150*dt end
	if obj.collisions.right == true then obj.x = obj.x - 150*dt end
end

function insideBox( px, py, x, y, wx, wy )
	if px > x and px < x + wx then
		if py > y and py < y + wy then
			return true
		end
	end
	return false
end
