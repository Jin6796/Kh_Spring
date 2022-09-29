package com.example.demo.khTest;

import java.io.IOException;
import java.util.Arrays;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Test {
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		Enumeration<String> names = req.getParameterNames();
		while (names.hasMoreElements()) {
			String name = (String) names.nextElement();
			String[] hobby = req.getParameterValues("name");
		}

	}
}
