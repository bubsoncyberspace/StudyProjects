package by.bsuir.bicyclerental.service;


import by.bsuir.bicyclerental.bean.entity.Product;
import by.bsuir.bicyclerental.bean.entity.ReportNode;
import by.bsuir.bicyclerental.service.exception.ServiceException;

import java.util.List;

/**
 * Created by ASUS on 19.10.2016.
 */
public interface SearchBicycleRentalService {

    List<Product> searchAllProducts() throws ServiceException;
    List<Product> searchProductByCategory(int categoryId) throws ServiceException;
    List<ReportNode> makeReport() throws ServiceException;
}
