package com.example.apprunner;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.io.File;  // Import the File class
import java.util.Scanner; // Import the Scanner class to read text files


@SpringBootApplication
@RestController
public class AppRunnerApplication {

	public static void main(String[] args) {
		SpringApplication.run(AppRunnerApplication.class, args);
	}

	@GetMapping
	public String hello(){
		Scanner reader = null;
		File myFile = null;
		String version = "";
		try{
			myFile = new File("version.txt");
			reader = new Scanner(myFile);
			while (reader.hasNextLine()) {
			  version = reader.nextLine();
			}
		}
		catch(Exception err){
			
			System.out.println(err.toString());
		}
		finally{
			if(reader != null)
				reader.close();
		}
		return version;
	}

}
