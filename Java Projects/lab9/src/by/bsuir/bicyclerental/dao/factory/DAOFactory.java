package by.bsuir.bicyclerental.dao.factory;


import by.bsuir.bicyclerental.dao.BicycleRentalDAO;
import by.bsuir.bicyclerental.dao.impl.ProductDAO;

public class DAOFactory {
	private static final DAOFactory INSTANCE = new DAOFactory();
		
	private BicycleRentalDAO bicycleRentalDAO = new ProductDAO();
	
	private DAOFactory(){}
	
	public static DAOFactory getInstance(){
		return INSTANCE;
	}
	
	public BicycleRentalDAO getProductDAO(){
		return bicycleRentalDAO;
	}

}
