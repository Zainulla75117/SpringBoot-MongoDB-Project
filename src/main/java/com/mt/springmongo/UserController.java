package com.mt.springmongo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/usersAndAdd")
    public String showUsersAndAddForm(Model model) {
        List<User> users = userRepository.findAll();
        model.addAttribute("users", users);
        return "usersAndAdd";
    }

    @PostMapping("/usersAndAdd")
    public String addUser(@RequestParam String firstName, @RequestParam String lastName, @RequestParam String email, Model model) {
        User user = new User(firstName, lastName, email);
        userRepository.save(user);
        List<User> users = userRepository.findAll();
        model.addAttribute("users", users);
        return "usersAndAdd";
    }
}
