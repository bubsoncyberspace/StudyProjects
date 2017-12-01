package by.bsuir.bicyclerental.command.impl;

import by.bsuir.bicyclerental.bean.entity.ReportNode;
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
public class MakeReport implements Command{
    @Override
    public String execute(HttpServletRequest request) {
        ServiceFactory factory = ServiceFactory.getInstance();
        SearchBicycleRentalService searchService = factory.getSearchNoteBookService();

        List<ReportNode> reportNodeList;
        try{
            reportNodeList = searchService.makeReport();
            request.setAttribute("reports", reportNodeList);
            return "report.jsp";

        } catch (ServiceException e) {
            request.setAttribute("status", MessageConstant.NOTSUCCESS_REPORT_MSG);
            return "index.jsp";
        }

    }
}
