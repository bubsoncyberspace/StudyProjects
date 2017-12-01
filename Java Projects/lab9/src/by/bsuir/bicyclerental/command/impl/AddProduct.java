package by.bsuir.bicyclerental.command.impl;

import by.bsuir.bicyclerental.command.Command;
import by.bsuir.bicyclerental.constants.MessageConstant;
import by.bsuir.bicyclerental.service.EditBicycleRentalService;
import by.bsuir.bicyclerental.service.exception.ServiceException;
import by.bsuir.bicyclerental.service.factory.ServiceFactory;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by ASUS on 19.10.2016.
 */
public class AddProduct implements Command {

    @Override
    public String execute(HttpServletRequest request) {

        ServiceFactory factory = ServiceFactory.getInstance();
        EditBicycleRentalService editService = factory.getEditNoteBookService();

        double price = Double.parseDouble(request.getParameter("price"));
        int idCategory = Integer.parseInt(request.getParameter("id_category"));

        try{
            editService.addProduct(request.getParameter("name"), price,
                    request.getParameter("description"), idCategory);
            request.setAttribute("status", MessageConstant.SUCCESS_ADD_MSG);
        } catch (ServiceException e) {
            request.setAttribute("status", MessageConstant.NOTSUCCESS_ADD_MSG);
        }

        return "index.jsp";
    }
}
