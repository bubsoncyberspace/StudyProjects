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
public class DeleteProduct implements Command{
    @Override
    public String execute(HttpServletRequest request) {

        ServiceFactory factory = ServiceFactory.getInstance();
        EditBicycleRentalService editService = factory.getEditNoteBookService();

        int id = Integer.parseInt(request.getParameter("id"));

        try{
            editService.deleteProduct(id);
            request.setAttribute("status", MessageConstant.SUCCESS_DELETE_MSG);
        } catch (ServiceException e) {
            request.setAttribute("status", MessageConstant.NOTSUCCESS_EDIT_MSG);
        }

        return "index.jsp";
    }

}
