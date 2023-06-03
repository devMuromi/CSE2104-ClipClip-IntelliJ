package myBean.db;

import javax.naming.*;
import java.sql.*;
import javax.sql.DataSource;

public class DsCon {
    public static Connection getConnection() throws NamingException, SQLException {
        Context init = new InitialContext();
        DataSource ds = (DataSource)init.lookup("java:/comp/env/jdbc/clipartdb");
        return ds.getConnection();
    }
}
