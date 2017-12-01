package by.bsuir.bicyclerental.command;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by ASUS on 19.10.2016.
 */
public interface Command {
    String execute(HttpServletRequest request);
}
