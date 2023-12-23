
const express = require('express')
const app = express()

app.use(express.json())

let todos = [
            {id: 1, title: 'Mow the lawn', priority: 'high'},
            {id: 2, title: 'Feed the rabbit', priority: 'medium'},
            {id: 3, title: 'Clean the car', priority: 'low'}
]

app.delete('/todos/:taskId', (req, res) => {
  let taskId = parseInt(req.params.taskId)
  todos = todos.filter(todo => todo.id != taskId)
  res.json({success: true, message: 'Task has been deleted'})
})

app.post('/todos', (req, res) => {
  
  const title = req.body.title
  const priority = req.body.priority
  
  const todo = {id: todos.length + 1, title: title, priority: priority}
  
  todos.push(todo)
  
  res.json({success: true, message: 'Task has been created'})
})

app.get('/todos', (req, res) => {
  res.json(todos)
})

app.listen(8080, () => {
  console.log('Server is running...')
})