console = {}
inConsole = false
consoleStr = ""
devConsole = false
function console.keypressed(key)
	if key == "return" then
		checkStr(consoleStr)
		inConsole = false
	elseif key == "escape" then
		inConsole = false
	elseif key == "backspace" then
		consoleStr = string.sub(consoleStr, 1, #consoleStr-1)
	end
end

function console.textinput(t)
	if t ~= "`" then
		consoleStr = consoleStr .. t
	end
end

function console.draw()
	if inConsole then
		love.graphics.setColor(0,0,0)
		love.graphics.rectangle("fill",0,0,800,50)
		love.graphics.setColor(255,255,255)
		love.graphics.print(consoleStr, 0, 2, 0, 1, 1)
	end
end


function checkStr(str)
	if devConsole == false then
		local fail = false
		if str == "settingNum1" then //Check for various phrases (cheat-codes)
			//Do something based on cheat code entered
		elseif str == "devConsole" //Enable developer console
			devConsole = true //Turn on developer console
		else
			fail = true
		end
		if fail == true then
			playSound(failSound)
		else
			playSound(consoleSound)
		end
		consoleStr = ""
	else //Use dev console
		print("Running Code:" .. consoleStr) //Tell user what they are running
		love.filesystem.write("dev.lua", consoleStr) //save code to file
		local chunk = love.filesystem.load("dev.lua", consoleStr) //load file
		chunk() //Run file
		consoleStr = "" //reset consoleStr
	end
end
