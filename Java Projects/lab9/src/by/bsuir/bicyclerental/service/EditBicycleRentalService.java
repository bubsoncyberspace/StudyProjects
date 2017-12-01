package by.bsuir.bicyclerental.service;

import by.bsuir.bicyclerental.service.exception.ServiceException;

/**
 * Created by ASUS on 19.10.2016.
 */
public interface EditBicycleRentalService {

    void addProduct(String name, double price, String description, int categoryId) throws ServiceException;
    void editProduct(int productId, String name, double price, String description, int categoryId) throws ServiceException;
    void deleteProduct(int productId) throws ServiceException;
}
