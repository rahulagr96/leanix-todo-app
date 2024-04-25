package com.leanix.todoapp.repository;

import com.leanix.todoapp.model.Todo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

// Repository interface for Todo entity
@Repository
public interface TodoRepository extends JpaRepository<Todo, Long> {
}