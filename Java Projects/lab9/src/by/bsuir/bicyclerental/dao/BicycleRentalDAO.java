package by.bsuir.bicyclerental.dao;

import by.bsuir.bicyclerental.bean.entity.Category;
import by.bsuir.bicyclerental.bean.entity.Product;
import by.bsuir.bicyclerental.bean.entity.ReportNode;
import by.bsuir.bicyclerental.dao.exception.DAOException;

import java.util.List;

/**
 * Created by ASUS on 19.10.2016.
 */
public interface BicycleRentalDAO {
    void addProduct(Product product) throws DAOException;

    List<Product> findProductsByCategory(Category category) throws DAOException;

    void deleteProduct(Product product) throws DAOException;

    void updateProduct(Product product) throws DAOException;

    List<Product> findAllProducts() throws DAOException;

    List<ReportNode> makeReport() throws DAOException;

}
