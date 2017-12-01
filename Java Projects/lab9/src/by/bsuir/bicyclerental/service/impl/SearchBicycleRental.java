package by.bsuir.bicyclerental.service.impl;

import by.bsuir.bicyclerental.bean.entity.Category;
import by.bsuir.bicyclerental.bean.entity.Product;
import by.bsuir.bicyclerental.bean.entity.ReportNode;
import by.bsuir.bicyclerental.constants.ExceptionConstant;
import by.bsuir.bicyclerental.dao.BicycleRentalDAO;
import by.bsuir.bicyclerental.dao.exception.DAOException;
import by.bsuir.bicyclerental.dao.factory.DAOFactory;
import by.bsuir.bicyclerental.service.SearchBicycleRentalService;
import by.bsuir.bicyclerental.service.exception.ServiceException;

import java.util.List;

/**
 * Created by ASUS on 19.10.2016.
 */
public class SearchBicycleRental implements SearchBicycleRentalService{
    @Override
    public List<Product> searchAllProducts() throws ServiceException {
        DAOFactory factory = DAOFactory.getInstance();
        BicycleRentalDAO dao = factory.getProductDAO();

        try {
            return dao.findAllProducts();
        } catch (DAOException e) {
            throw new ServiceException(ExceptionConstant.OPERATION_ERROR, e);
        }
    }

    @Override
    public List<Product> searchProductByCategory(int categoryId) throws ServiceException {
        if(!Validator.validateId(categoryId)){
            throw new ServiceException(ExceptionConstant.INVALID_INPUT_DATA);
        }

        DAOFactory factory = DAOFactory.getInstance();
        BicycleRentalDAO dao = factory.getProductDAO();

        Category Category = new Category();
        Category.setId(categoryId);
        try {
            return dao.findProductsByCategory(Category);
        } catch (DAOException e) {
            throw new ServiceException(ExceptionConstant.OPERATION_ERROR, e);
        }
    }

    @Override
    public List<ReportNode> makeReport() throws ServiceException {
        DAOFactory factory = DAOFactory.getInstance();
        BicycleRentalDAO dao = factory.getProductDAO();

        try {
            return dao.makeReport();
        } catch (DAOException e) {
            throw new ServiceException(ExceptionConstant.OPERATION_ERROR, e);
        }
    }


}
