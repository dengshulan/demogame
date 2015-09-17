local scene, frameCounter, cleanFlag

local function test1()
    local param = {
        enemyType = 1,
        startX = 0,
        startY = winSize.height / 2,
        endX = winSize.width * 0.75,
        endY = winSize.height * 0.75,
        speed = 100,
    }
    StageAgent:addEnemy(param)
end

local function test2()
    local param = {
        enemyType = 1,
        startX = winSize.width,
        startY = winSize.height / 2,
        endX = winSize.width * 0.25,
        endY = winSize.height * 0.75,
        speed = 100,
    }
    StageAgent:addEnemy(param)
end

local function test3()
    local param = {
        enemyType = 2,
        startX = winSize.width,
        startY = winSize.height / 2,
        endX = winSize.width * 0.25,
        endY = winSize.height * 0.75,
        speed = 100,
    }
    StageAgent:addEnemy(param)
    cleanFlag = true
end

local taskList = {}
taskList[60] = test1
taskList[120] = test2
taskList[180] = test3

local function init()
    frameCounter = 0
    cleanFlag = false
end

ThirdStage = {}

function ThirdStage:create()
    
    ThirdStage.background = GameScene_BG
    ThirdStage.nextStage = nil
    
    scene = CCScene:create()
    init()
    return scene
end

function ThirdStage:common_schedule()
    
    frameCounter = frameCounter + 1
    
    if frameCounter % 20 == 0 then
        StageAgent:playerShot()
        StageAgent:enemyShot()
    end
    
    StageAgent:moveBullets()
    
    local task = taskList[frameCounter]
    
    if task then
        task()
    end
    
    if cleanFlag and StageAgent:getEnemyArray():count() == 0 then
        cleanFlag = false
        StageAgent:nextStage()
    end
    
end