package by.bsuir.bicyclerental.service.factory;

import by.bsuir.bicyclerental.service.EditBicycleRentalService;
import by.bsuir.bicyclerental.service.SearchBicycleRentalService;
import by.bsuir.bicyclerental.service.impl.EditBicycleRental;
import by.bsuir.bicyclerental.service.impl.SearchBicycleRental;

public class ServiceFactory {
	private static final ServiceFactory instance = new ServiceFactory();
	
	private EditBicycleRentalService editBicycleRentalService = new EditBicycleRental();
	private SearchBicycleRentalService searchBicycleRentalService = new SearchBicycleRental();
	
	private ServiceFactory(){}
	
	
	public static ServiceFactory getInstance(){
		return instance;
	}
	
	public EditBicycleRentalService getEditNoteBookService(){
		return editBicycleRentalService;
	}
	
	public SearchBicycleRentalService getSearchNoteBookService(){
		return searchBicycleRentalService;
	}

}
