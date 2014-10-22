util = require("./utils")

container = exports = module.exports = {}

container.initContainer = ->
  @settings = {}
  @tasks = {}
  @setDefaultConfig()

container.setDefaultConfig = ->
  @set "interval", 1

container.set = (setting, val) ->
  if arguments.length is 1
    return this.settings[setting]

  this.settings[setting] = val

container.registerTask = (taskName, fn)->
  if !util.is("Function", fn)
    throw new Error("callback function required")

  @tasks[taskName] =
    fn: fn

container.removeTask = (taskName)->
  container.tasks[taskName] = null

container.addTaskEntity = (taskName, entity)->
  if !@tasks[taskName]
    throw new Error("Task name invalid.")

  hash = util.getHash entity
  task = @tasks[taskName]

  if !task[hash]
    task[hash] =
      entity: entity
      count: 1
  else
    task[hash].count++

  if !@started
    @begin()

container.begin = ->
  self = this
  @started = true
  @timer = setInterval ->
    self.runTask()
  , self.set("interval") * 60 * 1000

container.stop = ->
  if @timer
    clearInterval @timer

  @started = false

container.runTask = ->
  for taskName, task of @tasks
    if task
      for hash, obj of task
        if hash isnt "fn" and obj.count > 0
          try
            task.fn(obj)
          catch err
            console.error err

          obj.count = 0
  return