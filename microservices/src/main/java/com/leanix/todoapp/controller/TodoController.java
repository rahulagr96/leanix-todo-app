package com.leanix.todoapp.controller;

import com.leanix.todoapp.model.Todo;
import com.leanix.todoapp.service.TodoService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/todos")
public class TodoController {
    private final TodoService todoService;

    // Constructor injection of TodoService
    public TodoController(TodoService todoService) {
        this.todoService = todoService;
    }

    // Endpoint to get all todos
    @GetMapping
    public List<Todo> getAllTodos() {
        return todoService.getAllTodos();
    }

    // Endpoint to get todo by id
    @GetMapping("/{id}")
    public Todo getTodoById(@PathVariable Long id) {
        return todoService.getTodoById(id);
    }

    // Endpoint to create a new todo
    @PostMapping
    public Todo createTodo(@RequestBody Todo todo) {
        return todoService.createTodo(todo);
    }

    // Endpoint to update an existing todo
    @PutMapping("/{id}")
    public Todo updateTodo(@PathVariable Long id, @RequestBody Todo todo) {
        return todoService.updateTodo(id, todo);
    }

    // Endpoint to delete a todo
    @DeleteMapping("/{id}")
    public String deleteTodo(@PathVariable Long id) {
        return todoService.deleteTodo(id);
    }

    // Health check endpoint
    @GetMapping("/health")
    public String healthCheck() {
        return "Health Check: Green";
    }
}