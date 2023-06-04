package myBean.db;

import java.sql.*;
import java.time.LocalDateTime;
import javax.naming.NamingException;
import myBean.db.DsCon;
import jakarta.servlet.http.Part;

public class UserDB {
    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public UserDB() throws NamingException, SQLException {
        con = DsCon.getConnection();
    }

    public boolean checkPassword(String username, String password) throws SQLException {
        String sql = "SELECT password FROM user WHERE username = ? AND password = PASSWORD(?)";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, username);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        boolean passwordMatched = rs.next();
        return passwordMatched;
    }

    public int insertRecord(User user) throws SQLException {
        String sql = "INSERT INTO user(username, password, isAdmin, createDate) VALUES(?, PASSWORD(?), ?, ?)";

        pstmt = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
        pstmt.setString(1, user.getUsername());
        pstmt.setString(2, user.getPassword());
        pstmt.setBoolean(3, user.isAdmin());

        LocalDateTime createDate = user.getCreateDate();
        java.sql.Timestamp sqlCreateDate = java.sql.Timestamp.valueOf(createDate);
        pstmt.setTimestamp(4, sqlCreateDate);

        pstmt.executeUpdate();

        int generatedId = -1;
        rs = pstmt.getGeneratedKeys();
        if (rs.next()) {
            generatedId = rs.getInt(1);
        }
        return generatedId;
    }

    public User getRecord(String username) throws SQLException {
        User user = new User();
        String sql = "SELECT id, isAdmin, createDate FROM user WHERE username=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();
        rs.next();

        user.setUsername(username);
        user.setAdmin(rs.getBoolean("isAdmin"));
        user.setId(rs.getInt("id"));
        user.setCreateDate(rs.getTimestamp("createDate").toLocalDateTime());
        return user;
    }
    public void close() throws SQLException {
        if(rs != null) rs.close();
        if(pstmt != null) pstmt.close();
        if(con != null) con.close();
    }
}