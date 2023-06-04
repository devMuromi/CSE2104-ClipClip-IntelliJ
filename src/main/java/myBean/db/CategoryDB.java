package myBean.db;

import java.sql.*;
import javax.naming.NamingException;
import myBean.db.DsCon;

public class CategoryDB {
    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet rs;


    public CategoryDB() throws NamingException, SQLException {
        con = DsCon.getConnection();

    }

    public void insertRecord(Category category) throws SQLException {
        String sql = "INSERT INTO category(name) VALUES(?)";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, category.getName());

        pstmt.executeUpdate();
    }

    public Category getRecord(int id) throws SQLException {
        Category category = new Category();
        String sql = "SELECT name FROM category WHERE id=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();
        rs.next();

        category.setId(id);
        category.setName(rs.getString("name"));

        return category;
    }

    public void deleteRecord(int id) throws SQLException {
        String sql = "DELETE FROM category WHERE id=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, id);
        pstmt.executeUpdate();
    }

    public void close() throws SQLException {
        if(rs != null) rs.close();
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
}