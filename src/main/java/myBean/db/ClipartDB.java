package myBean.db;

import java.sql.*;
import java.time.LocalDateTime;
import javax.naming.NamingException;
import myBean.db.DsCon;
import jakarta.servlet.http.Part;

public class ClipartDB {
    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet rs;


    public ClipartDB() throws NamingException, SQLException {
        con = DsCon.getConnection();
    }

    public boolean checkPassword(int id, String password) throws SQLException {
        String sql = "SELECT password FROM clipart WHERE id = ? AND password = PASSWORD(?)";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, id);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        boolean passwordMatched = rs.next();
        return passwordMatched;
    }

    public int insertRecord(Clipart clipart) throws SQLException {
        String sql = "INSERT INTO clipart(title, author, categoryId, password, tags, description, viewCount, downloadCount, createDate, lastUpdate, originalFileName, savedFileName) VALUES(?, ?, ?, PASSWORD(?), ?, ?, ?, ?, ?, ?, ?, ?)";

        pstmt = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
        pstmt.setString(1, clipart.getTitle());
        pstmt.setString(2, clipart.getAuthor());
        pstmt.setInt(3, clipart.getCategoryId());
        pstmt.setString(4, clipart.getPassword());
        pstmt.setString(5, String.join(",", clipart.getTags()));
        pstmt.setString(6, clipart.getDescription());
        pstmt.setInt(7, clipart.getViewCount());
        pstmt.setInt(8, clipart.getDownloadCount());

        LocalDateTime createDate = clipart.getCreateDate();
        java.sql.Timestamp sqlCreateDate = java.sql.Timestamp.valueOf(createDate);
        pstmt.setTimestamp(9, sqlCreateDate);

        LocalDateTime lastUpdate = clipart.getLastUpdate();
        java.sql.Timestamp sqlLastUpdate = java.sql.Timestamp.valueOf(lastUpdate);
        pstmt.setTimestamp(10, sqlLastUpdate);

        pstmt.setString(11, clipart.getOriginalFileName());
        pstmt.setString(12, clipart.getSavedFileName());
        pstmt.executeUpdate();

        int generatedId = -1;
        rs = pstmt.getGeneratedKeys();
        if (rs.next()) {
            generatedId = rs.getInt(1);
        }
        return generatedId;
    }

    public Clipart getRecord(int id) throws SQLException {
        Clipart clipart = new Clipart();
        String sql = "SELECT title, author, categoryId, tags, description, viewCount, downloadCount, createDate, lastUpdate, originalFileName, savedFileName FROM clipart WHERE id=?";
        pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();
        rs.next();

        clipart.setId(id);
        clipart.setTitle(rs.getString("title"));
        clipart.setAuthor(rs.getString("author"));
        clipart.setCategoryId(rs.getInt("categoryId"));
        clipart.setTags(rs.getString("tags").split(","));
        clipart.setDescription(rs.getString("description"));
        clipart.setViewCount(rs.getInt("viewCount"));
        clipart.setDownloadCount(rs.getInt("downloadCount"));
        clipart.setCreateDate(rs.getTimestamp("createDate").toLocalDateTime());
        clipart.setLastUpdate(rs.getTimestamp("lastUpdate").toLocalDateTime());
        clipart.setOriginalFileName(rs.getString("originalFileName"));
        clipart.setSavedFileName(rs.getString("savedFileName"));
        return clipart;
    }

//    public void updateRecord(Clipart art) throws SQLException {
////        String sql = "INSERT INTO clipart(title, user, category_id, password, tags, description, file, create_date, last_update) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
//
//        String sql = "UPDATE clipart SET id=?, name=?, pwd=? WHERE idx=?";
//        pstmt = con.prepareStatement(sql);
//
//        pstmt.setString(1, art.getId());
//        pstmt.setString(2, art.getName());
//        pstmt.setString(3, art.getPwd());
//        pstmt.setInt(4, art.getIdx());
//
//        pstmt.executeUpdate();
//    }

    public void deleteRecord(int id) throws SQLException {
        String sql = "DELETE FROM clipart WHERE id=?";
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