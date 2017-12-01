package by.bsuir.bicyclerental.command.impl;

import by.bsuir.bicyclerental.bean.entity.Product;
import by.bsuir.bicyclerental.command.Command;
import by.bsuir.bicyclerental.constants.MessageConstant;
import by.bsuir.bicyclerental.service.SearchBicycleRentalService;
import by.bsuir.bicyclerental.service.exception.ServiceException;
import by.bsuir.bicyclerental.service.factory.ServiceFactory;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by ASUS on 19.10.2016.
 */
public class SearchAllProducts implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        ServiceFactory factory = ServiceFactory.getInstance();
        SearchBicycleRentalService searchService = factory.getSearchNoteBookService();

        List<Product> products;
        try{
            products = searchService.searchAllProducts();
            request.setAttribute("products", products);
            return "products.jsp";
        } catch (ServiceException e) {
            request.setAttribute("status", MessageConstant.NOTSUCCESS_SEARCH_ALL_MSG);
            return "index.jsp";
        }


    }
}
