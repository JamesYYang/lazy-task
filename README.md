lazy-task
=========

Lazy task with removing duplicate items. 

If you are troubled with that huge function call during a inteval, and argument are exactlly same, and you want this function only called once. Lazy task is what you want.


## install 

```
npm install lazy-task
```

## how to use

```js
  lazyTask = require("lazy-task");

  lazyTask.set("interval", 1); //set interval by minute

  // register task and call back
  lazyTask.registerTask("Test", function(obj) {
    console.log("Task: Test");
    console.log("Dupliate count: " + obj.count);
    return console.dir(obj.entity);
  });

  testEntity = {
    message: "hello lazy task"
  };

  i = 0;

  while (i < 10) {
    // add to content to task
    lazyTask.addTaskEntity("Test", testEntity);
    i++;
  }
```

So after one minute, you will get following output:

```
Task: Test
Duplicate count: 10
{ message: 'hello lazy task' }
```
