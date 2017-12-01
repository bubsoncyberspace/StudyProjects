import javax.swing.*;
import java.awt.event.*;

public class EditDialog extends JDialog {
    private JPanel contentPane;
    private JButton buttonOK;
    private JLabel surnameLabel;
    private JTextField surnameField;
    private JLabel nameLabel;
    private JLabel lastNameLabel;
    private JLabel dateOfBirthLabel;
    private JLabel positionLabel;
    private JLabel specializationLabel;
    private JTextField nameField;
    private JTextField lastNameField;
    private JTextField dateOfBirthField;
    private JTextField positionField;
    private JTextField specializationField;
    private JLabel idLabel;
    private JTextField idField;

    public EditDialog() {
        this.setSize(400, 400);
        setContentPane(contentPane);
        setModal(true);
        getRootPane().setDefaultButton(buttonOK);

        buttonOK.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                onOK();
            }
        });

    }

    private void onOK() {
        this.setVisible(false);
    }


    public String getId()
    {
        return idField.getText();
    }
    public String getSurname()
    {
        return surnameField.getText();
    }
    public String getName()
    {
        return nameField.getText();
    }
    public String getLastName()
    {
        return lastNameField.getText();
    }
    public String getDateOfBirth()
    {
        return dateOfBirthField.getText();
    }
    public String getPosition()
    {
        return positionField.getText();
    }
    public String getSpecialization(){
        return specializationField.getText();
    }
    public void setId(String Id)
    {
        idField.setText(Id);
    }
    public void setSurname(String surname)
    {
        surnameField.setText(surname);
    }
    public void setName(String Name)
    {
        nameField.setText(Name);
    }
    public void setLastName(String lastname)
    {
        lastNameField.setText(lastname);
    }
    public void setDateOfBirth(String dateOfBirth)
    {
        dateOfBirthField.setText(dateOfBirth);
    }
    public void setPosition(String position)
    {
        positionField.setText(position);
    }
    public void setSpecialization(String specialization)
    {
        specializationField.setText(specialization);
    }

}
