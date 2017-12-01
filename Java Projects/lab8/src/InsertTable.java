import javax.swing.*;
import java.awt.event.*;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;


public class InsertTable extends JFrame{
    private JTextField nameField;
    private JTextField lastNameField;
    private JLabel nameLabel;
    private JLabel lastNameLabel;
    private JLabel surnameLabel;
    private JLabel dateOfBirthLabel;
    private JLabel positionLabel;
    private JTextField dateOfBirthField;
    private JTextField positionField;
    private JButton sendButton;
    private JTable doctorTable;
    private JPanel mainPanel;
    private JLabel commentLabel;
    private JButton editButton;
    private JButton deleteButton;
    private JLabel specializationLabel;
    private JTextField specializationField;
    private JLabel idLabel;
    private JTextField idField;
    private JTextField surnameField;
    private MyDBConnection mdbc;
    private java.sql.Statement stmt;
    private EditDialog dlg;

    public InsertTable() {
        dlg = new EditDialog();
        this.setSize(400, 600);
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setContentPane(mainPanel);
        try
        {
            mdbc = new MyDBConnection();
            mdbc.init();
            Connection conn = mdbc.getMyConnection();
            stmt = conn.createStatement();
        }
        catch(Exception e){}
        initComponents();
        sendButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String Id = idField.getText();
                String Surname = surnameField.getText();
                String Name = nameField.getText();
                String Lastname = lastNameField.getText();
                String DateOfBirth = dateOfBirthField.getText();
                String Position = positionField.getText();
                String Specialization = specializationField.getText();
                String insertStr = "";
                try
                {
                    insertStr = "INSERT INTO doctor VALUES ("
                            + quotate(Id) + ","
                            + quotate(Surname) + ","
                            + quotate(Name) + ","
                            + quotate(Lastname) + ","
                            + quotate(DateOfBirth) + ","
                            + quotate(Position) + ","
                            + quotate(Specialization) + ")";
                    int done = stmt.executeUpdate(insertStr);
                    commentLabel.setText("1 row inserted");
                    initComponents();
                }
                catch(Exception ex)
                {
                    commentLabel.setText("Error occured in inserting data");
                }
            }
        });

        editButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                dlg.setId((String) doctorTable.getValueAt(doctorTable.getSelectedRow(), 0));
                dlg.setSurname((String) doctorTable.getValueAt(doctorTable.getSelectedRow(), 1));
                dlg.setName((String) doctorTable.getValueAt(doctorTable.getSelectedRow(), 2));
                dlg.setLastName((String) doctorTable.getValueAt(doctorTable.getSelectedRow(), 3));
                dlg.setDateOfBirth((String) doctorTable.getValueAt(doctorTable.getSelectedRow(), 4));
                dlg.setPosition((String) doctorTable.getValueAt(doctorTable.getSelectedRow(), 5));
                dlg.setSpecialization((String) doctorTable.getValueAt(doctorTable.getSelectedRow(), 6));

                dlg.setVisible(true);
                try
                {
                    String insertStr = "UPDATE doctor SET surname="
                            + quotate(dlg.getSurname()) + "WHERE id =" + (String) doctorTable.getValueAt(doctorTable.getSelectedRow(), 0);
                    int done = stmt.executeUpdate(insertStr);
                    insertStr = "UPDATE doctor SET name="
                            + quotate(dlg.getName()) + "WHERE id =" + (String) doctorTable.getValueAt(doctorTable.getSelectedRow(), 0);
                    done = stmt.executeUpdate(insertStr);
                    insertStr = "UPDATE doctor SET lastname="
                            + quotate(dlg.getLastName()) + "WHERE id =" + (String) doctorTable.getValueAt(doctorTable.getSelectedRow(), 0);
                    done = stmt.executeUpdate(insertStr);
                    insertStr = "UPDATE doctor SET dateOfBirth="
                            + quotate(dlg.getDateOfBirth()) + "WHERE id =" + (String) doctorTable.getValueAt(doctorTable.getSelectedRow(), 0);
                    done = stmt.executeUpdate(insertStr);
                    insertStr = "UPDATE doctor SET position="
                            + quotate(dlg.getPosition()) + "WHERE id =" + (String) doctorTable.getValueAt(doctorTable.getSelectedRow(), 0);
                    done = stmt.executeUpdate(insertStr);
                    insertStr = "UPDATE doctor SET specialization="
                            + quotate(dlg.getSpecialization()) + "WHERE id =" + (String) doctorTable.getValueAt(doctorTable.getSelectedRow(), 0);
                    done = stmt.executeUpdate(insertStr);
                    insertStr = "UPDATE doctor SET id="
                            + quotate(dlg.getId()) + "WHERE id =" + (String) doctorTable.getValueAt(doctorTable.getSelectedRow(), 0);
                    done = stmt.executeUpdate(insertStr);
                    initComponents();
                }
                catch(Exception ex)
                {
                    System.out.println("Error occured in editing data");
                }
            }
        });
        deleteButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String Id = (String) doctorTable.getValueAt(doctorTable.getSelectedRow(), 0);
                String insertStr = "";
                try
                {
                    insertStr = "DELETE FROM doctor WHERE id=" + Id;
                    int done = stmt.executeUpdate(insertStr);
                    commentLabel.setText("1 row deleted");
                    initComponents();
                }
                catch(Exception ex)
                {
                    commentLabel.setText("Error occured in deleting data");
                }
            }
        });
        doctorTable.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                if(doctorTable.getSelectedRowCount() > 0)
                {
                    editButton.setEnabled(true);
                    deleteButton.setEnabled(true);
                }
                else
                {
                    editButton.setEnabled(false);
                    deleteButton.setEnabled(false);
                }
            }
        });
        mainPanel.addComponentListener(new ComponentAdapter() {
        });

        this.addWindowListener(new WindowAdapter(){
            @Override
            public void windowClosing(WindowEvent e) {
                try
                {
                    mdbc.close(stmt.getResultSet());
                    mdbc.destroy();
                }
                catch (SQLException ex){}
            }
        });
    }

    public ResultSet getResultFromClinic()
    {
        ResultSet rs = null;
        try
        {
            rs = stmt.executeQuery("SELECT * FROM `doctor`");
        }
        catch(SQLException e){}
        return rs;
    }

    public String quotate(String content){
        return " ' " + content + " ' ";
    }

    public void initComponents() {
        editButton.setEnabled(false);
        deleteButton.setEnabled(false);
        ResultSet rs = getResultFromClinic();
        doctorTable.setModel(new DoctorModel(rs));
        mdbc.close(rs);
    }





}
