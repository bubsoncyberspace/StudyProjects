package by.bsuir.bicyclerental.controller;


import by.bsuir.bicyclerental.command.Command;
import by.bsuir.bicyclerental.command.impl.*;

import java.util.HashMap;
import java.util.Map;

class CommandProvider {
	private Map<String, Command> commands = new HashMap<String, Command>();
	
	CommandProvider() {
		commands.put("ADD_PRODUCT", new AddProduct());
		commands.put("DELETE_PRODUCT", new DeleteProduct());
		commands.put("EDIT_PRODUCT", new EditProduct());
		commands.put("SEARCH_ALL_PRODUCTS", new SearchAllProducts());
		commands.put("SEARCH_PRODUCTS_BY_CATEGORY", new SearchProductsByCategory());
		commands.put("MAKE_REPORT", new MakeReport());
	}
	
	
	public Command getCommand(String commandName){
		Command command;
		command = commands.get(commandName);
		return command;
	}

}
