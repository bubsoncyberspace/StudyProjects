package by.bsuir.bicyclerental.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by ASUS on 25.10.2016.
 */
public class ControllerServlet extends HttpServlet {
    private final CommandProvider provider = new CommandProvider();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String pathToRedirect = process(request);
        request.getRequestDispatcher(pathToRedirect).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");
        String pathToRedirect = process(request);
        request.getRequestDispatcher(pathToRedirect).forward(request, response);

    }

    private String process(HttpServletRequest request){
        String command = request.getParameter("command");
        return provider.getCommand(command).execute(request);
    }
}
