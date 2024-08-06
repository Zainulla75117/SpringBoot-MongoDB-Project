package com.mt.springmongo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/users")
    public ModelAndView getAllUsers() {
        List<User> users = userRepository.findAll();
        ModelAndView mav = new ModelAndView("users");
        mav.addObject("users", users);
        return mav;
    }

    @GetMapping("/addUser")
    public String showAddUserForm() {
        return "input";
    }

    @PostMapping("/addUser")
    public String addUser(@RequestParam String firstName, @RequestParam String lastName, @RequestParam String email) {
        User user = new User(firstName, lastName, email);
        userRepository.save(user);
        return "redirect:/users";
    }
}

