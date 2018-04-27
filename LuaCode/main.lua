function love.load()
    love.window.setFullscreen(true)
    love.mouse.setVisible(false)
    width = love.graphics.getWidth( )
    height = love.graphics.getHeight( )
    local maxStars = 200
    planetImages = {sun = nil, tesla = nil, mercury = nil, venus = nil, earth = nil, mars = nil, moon = nil}
    planetImages.sun = love.graphics.newImage('assets/sun.png')
    planetImages.tesla = love.graphics.newImage('assets/teslaCar.png')
    planetImages.mercury = love.graphics.newImage('assets/mercury.png')
    planetImages.venus = love.graphics.newImage('assets/venus.png')
    planetImages.earth = love.graphics.newImage('assets/earth.png')
    planetImages.mars = love.graphics.newImage('assets/mars.png')
    planetImages.moon = love.graphics.newImage('assets/moon.png')
    showInstructions = true;
    stars = {}
    for i=1, maxStars do 
       local x = love.math.random(5, width-5) 
       local y = love.math.random(5, height-5) 
       stars[i] = {x, y} 
    end
    --img = love.graphics.newImage(assets/n.img)
    rOrbit = 1.6/1000000
    rEarthMoonOrbit = 1.6/20000
    rMarsMoonOrbit = 1.6/1750
    sunModifier = 1.7/60000
    rPlanet = 1.7/1500
    mercuryModifier = 0
    venusModifier = 0
    earthModifier = 0
    marsModifier = 0
    teslaModifier = 0
    circum = 2 * math.pi
    mercuryRate = 365/88
    venusRate = 365/225
    earthRate = 1
    marsRate = 365/687
    teslaRate = 365/557.1
    teslaSpinRate = 365/557.1;
    teslaRotate = 0;
    moonRate = 365/27;
    moonModifier = 0;
    phobosRate = 365/10;
    phobosModifier = 0;
    deimosRate = 365/23;
    deimosModifier = 0;

    showOrbits = false;
    pressed = false

    textScale = 1.3

    speedConst = .5;

    timer = 0;

end
function love.update(dt)
    if deimosModifier < 0 then
        deimosModifier = circum
    else
        deimosModifier = deimosModifier - (deimosRate * dt) * speedConst
    end
    
    if phobosModifier < 0 then
        phobosModifier = circum
    else
        phobosModifier = phobosModifier - (phobosRate * dt) * speedConst
    end

    if moonModifier < 0 then
        moonModifier = circum
    else
        moonModifier = moonModifier - (moonRate * dt) * speedConst
    end
    
    if teslaSpinRate < 0 then
        teslaRotate = circum * 2
    else
        teslaRotate = teslaRotate - (3 * (teslaSpinRate * dt)) * speedConst
    end

    if mercuryModifier < 0 then
        mercuryModifier = circum
    else
        mercuryModifier = mercuryModifier - ((mercuryRate * dt) * speedConst)
    end

    if venusModifier < 0 then
        venusModifier = circum
    else
        venusModifier = venusModifier - ((venusRate * dt) * speedConst)
    end

    if earthModifier < 0 then
        earthModifier = circum
    else
        earthModifier = earthModifier - ((earthRate * dt) * speedConst)
    end

    if marsModifier < 0 then
        marsModifier = circum
    else
        marsModifier = marsModifier - ((marsRate * dt) * speedConst)
    end

    if teslaModifier < 0 then
        teslaModifier = circum
    else
        teslaModifier = teslaModifier - ((teslaRate * dt) * speedConst)
    end
    
    if love.keyboard.isDown("o") then
        showOrbits = true
    else
       
        showOrbits = false
    end
    if love.keyboard.isDown('escape') then

        love.event.quit()
    end

    if love.keyboard.isDown('up') then
        if speedConst > 3 then
            speedConst = 3
        else
            speedConst = speedConst + (1 * dt)
        end
    end

    if love.keyboard.isDown('down') then
        if speedConst < 0.025 then
            speedConst = 0.025
        else
            speedConst = speedConst - (1 * dt )
        end
    end

    if timer >= 10 then
        showInstructions = false;
    else
        timer = timer + (1 * dt)
    end
    print(timer)
end

function love.draw(dt)
    drawColor(255, 255, 255)
    
    if showInstructions then
        love.graphics.print("Hold 'o' to see the planets orbits \nHold 'up arrow' to speed up the simulation \nHold 'down arrow' to slow down the simulation \nAll of the planets orbits are to scale to each other \nAll of the moon orbits are to scale to each other \nDue to size limitations the planets are not to scale \nand the moons orbits are not to scale with the planets orbits \nThese instructions will hide 10 seconds after launch of program", 0, 0, 0, textScale, textScale)
    end
    
    love.graphics.points(stars)
    love.graphics.translate( width/2.5, height/2 )
    drawColor(255, 100, 0)
    --love.graphics.circle("fill", 0, 0, 695508 * sunModifier, 5000)
    love.graphics.draw(planetImages.sun, 0,0, 0, 1/10, 1/10, planetImages.sun:getWidth()/2, planetImages.sun:getHeight()/2)
    if(showOrbits) then
        drawColorWithAlpha(255, 100, 100, 60)
        love.graphics.ellipse("line", 11907850 *rOrbit, 0, 57909050 *rOrbit, 56671520.010319114 *rOrbit, 200) --Mercury Orbit
        love.graphics.ellipse("line", 731000.0 *rOrbit, 0, 108208000.0 *rOrbit, 108205530.83368705 *rOrbit, 200) --Venus Orbit
        love.graphics.ellipse("line", 2502500.0 *rOrbit, 0, 149597500.0 *rOrbit, 149576567.34930107 *rOrbit, 200) --Earth Orbit
        love.graphics.ellipse("line", 21250000.0 *rOrbit, 0, 227950000.0 *rOrbit, 226957352.82206655 *rOrbit, 200) --Mars Orbit
        love.graphics.ellipse("line", 121922264.6205 *rOrbit, 0, 268528177.9065 *rOrbit, 239253722.47802892 *rOrbit, 200) --Tesla Roadster Orbit
        love.graphics.ellipse("line", (149597500.0 *rOrbit * math.cos(earthModifier)) + 2502500.0 *rOrbit, 149576567.34930107 * rOrbit * math.sin(earthModifier), 384000.0 * rEarthMoonOrbit, 383403.2342064944 * rEarthMoonOrbit, 200) --Moon Orbit
        love.graphics.ellipse("line", (227950000.0 *rOrbit * math.cos(marsModifier)) + 21250000.0 *rOrbit, 226957352.82206655 *rOrbit * math.sin(marsModifier), 9376.0 * rMarsMoonOrbit, 9374.930991938021 * rMarsMoonOrbit, 200) --Phobos Orbit
        love.graphics.ellipse("line", (227950000.0 *rOrbit * math.cos(marsModifier)) + 21250000.0 *rOrbit, 226957352.82206655 *rOrbit * math.sin(marsModifier), 23463.2 * rMarsMoonOrbit, 23463.198736532067 * rMarsMoonOrbit, 200) --Deimos Orbit
    end
    drawColor(255, 255, 255)
    createPlanet(11907850 *rOrbit, 0, 57909050 *rOrbit, 56671520.010319114 *rOrbit, 2440, rPlanet, mercuryModifier, "Mercury") --Mercury Planet
    createPlanet(731000.0 *rOrbit, 0, 108208000.0 *rOrbit, 108205530.83368705 *rOrbit, 6052, rPlanet, venusModifier, "Venus") --Venus Planet
    createPlanet(2502500.0 *rOrbit, 0, 149597500.0 *rOrbit, 149576567.34930107 *rOrbit, 6371 , rPlanet, earthModifier, "Earth") --Earth Planet
    createPlanet(21250000.0 *rOrbit, 0, 227950000.0 *rOrbit, 226957352.82206655 *rOrbit, 3390 , rPlanet, marsModifier, "Mars") --Mars Planet
    createPlanet(121922264.6205 *rOrbit, 0, 268528177.9065 *rOrbit, 239253722.47802892 *rOrbit, 3390 , rPlanet, teslaModifier, "Tesla")--Tesla Roadster Car
    createPlanet(149597500.0 *rOrbit * math.cos(earthModifier) + 2502500.0 * rOrbit, 149576567.34930107 * rOrbit * math.sin(earthModifier), 384000.0 *rEarthMoonOrbit, 383403.2342064944 *rEarthMoonOrbit, 40000 , rEarthMoonOrbit, moonModifier, "MoonM") --Moon
    createPlanet(227950000.0 *rOrbit * math.cos(marsModifier) + 21250000.0 * rOrbit, 226957352.82206655 * rOrbit * math.sin(marsModifier), 9376.0 *rMarsMoonOrbit, 9374.930991938021 * rMarsMoonOrbit, 30000 , rEarthMoonOrbit, phobosModifier, "MoonP") --Phobos
    createPlanet(227950000.0 *rOrbit * math.cos(marsModifier) + 21250000.0 * rOrbit, 226957352.82206655 * rOrbit * math.sin(marsModifier), 23463.2 * rMarsMoonOrbit, 23463.198736532067 * rMarsMoonOrbit, 40000 , rEarthMoonOrbit, deimosModifier, "MoonD") --Deimos
end

function drawColor(r, g, b)
    love.graphics.setColor(r/255, g/255, b/255)
end

function drawColorWithAlpha(r, g, b, a)
    love.graphics.setColor(r/255, g/255, b/255, a/100)
end

function createPlanet(xMove, yMove, xPos, yPos, radius, planetSizeModifier, modifierMove, title)
    --love.graphics.circle("fill", (xPos * math.cos(modifierMove)) +xMove, yPos * math.sin(modifierMove) + yMove, radius * planetSizeModifier, 5000)
    --love.graphics.draw( drawable, x, y, r, sx, sy, ox, oy, kx, ky )
    --love.graphics.draw(planetImages.sun, 0,0, 0, 1/10, 1/10, planetImages.sun:getWidth()/2, planetImages.sun:getHeight()/2)
    if title == "Tesla" then
        love.graphics.draw(planetImages.tesla, (xPos * math.cos(modifierMove)) + xMove,  yPos * math.sin(modifierMove), teslaRotate, 1/60, 1/60, planetImages.tesla:getWidth()/2, planetImages.tesla:getHeight()/2)
    else if title == "Mercury" then
        love.graphics.draw(planetImages.mercury, (xPos * math.cos(modifierMove)) + xMove,  yPos * math.sin(modifierMove), 0, 1/90, 1/90, planetImages.mercury:getWidth()/2, planetImages.mercury:getHeight()/2)
    else if title == "Venus" then
        love.graphics.draw(planetImages.venus, (xPos * math.cos(modifierMove)) + xMove,  yPos * math.sin(modifierMove), 0, 1/17, 1/17, planetImages.venus:getWidth()/2, planetImages.venus:getHeight()/2)
    else if title == "Earth" then
        love.graphics.draw(planetImages.earth, (xPos * math.cos(modifierMove)) + xMove,  yPos * math.sin(modifierMove), 0, 1/11, 1/11, planetImages.earth:getWidth()/2, planetImages.earth:getHeight()/2)
    else if title == "Mars" then
        love.graphics.draw(planetImages.mars, (xPos * math.cos(modifierMove)) + xMove,  yPos * math.sin(modifierMove), 0, 1/40, 1/40, planetImages.mars:getWidth()/2, planetImages.mars:getHeight()/2)
    else if title == "MoonM" then
        love.graphics.draw(planetImages.moon, (xPos * math.cos(modifierMove)) + xMove,  yPos * math.sin(modifierMove) + yMove, 0, 1/20, 1/20, planetImages.moon:getWidth()/2, planetImages.moon:getHeight()/2)
    else if title == "MoonP" then
        love.graphics.draw(planetImages.moon, (xPos * math.cos(modifierMove)) + xMove,  yPos * math.sin(modifierMove) + yMove, 0, 1/40, 1/40, planetImages.moon:getWidth()/2, planetImages.moon:getHeight()/2)
    else if title == "MoonD" then
        love.graphics.draw(planetImages.moon, (xPos * math.cos(modifierMove)) + xMove,  yPos * math.sin(modifierMove) + yMove, 0, 1/30, 1/30, planetImages.moon:getWidth()/2, planetImages.moon:getHeight()/2)
    else    
        love.graphics.circle("fill", (xPos * math.cos(modifierMove)) +xMove, yPos * math.sin(modifierMove) + yMove, radius * planetSizeModifier, 5000)
    end
    end
    end
    end
    end
    end
    end
    end
end