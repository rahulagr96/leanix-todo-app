package com.leanix.todoapp.service;

import com.leanix.todoapp.model.Todo;
import com.leanix.todoapp.repository.TodoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import static org.springframework.http.HttpStatus.NOT_FOUND;
import java.util.List;

@Service
public class TodoService {
    @Autowired
    private final TodoRepository todoRepository;

    // Constructor injection of TodoRepository
    public TodoService(TodoRepository todoRepository) {
        this.todoRepository = todoRepository;
    }

    // Get all todos
    public List<Todo> getAllTodos() {
        return todoRepository.findAll();
    }

    // Get todo by ID
    public Todo getTodoById(Long id) {
        return todoRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(NOT_FOUND, "Todo not found with id: " + id));
    }

    // Create a new todo
    public Todo createTodo(Todo todo) {
        return todoRepository.save(todo);
    }

    // Update an existing todo
    public Todo updateTodo(Long id, Todo updatedTodo) {
        Todo todo = getTodoById(id);
        todo.setTitle(updatedTodo.getTitle());
        todo.setDescription(updatedTodo.getDescription());
        todo.setCompleted(updatedTodo.isCompleted());
        return todoRepository.save(todo);
    }

    // Delete a todo
    public String deleteTodo(Long id) {
        Todo todo = getTodoById(id);
        if (todo != null) {
            todoRepository.delete(todo);
            return "Data deletion success with id: " + id;
        } else {
            return "Data deletion failed!";
        }
    }
}