package myBean.db;

import myBean.multipart.MyPart;

import java.time.LocalDateTime;
import java.util.Date;

public class Clipart
{
    private int id;
    private String title;
    private String author;
    private int categoryId;
    private String password;
    private String[] tags;
    private String description;
    private int viewCount;
    private int downloadCount;
    private LocalDateTime createDate;
    private LocalDateTime lastUpdate;
    private MyPart part;

    public Clipart() {
    }

    public int getId() {
        return id;
    }
    public void setId(int id) {this.id = id;}

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }
    public void setAuthor(String author) {
        this.author = author;
    }

    public int getCategoryId() {
        return categoryId;
    }
    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String[] getTags() {
        return tags;
    }
    public void setTags(String[] tags) {
        this.tags = tags;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public int getViewCount() {
        return viewCount;
    }
    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public int getDownloadCount() {
        return downloadCount;
    }
    public void setDownloadCount(int downloadCount) {
        this.downloadCount = downloadCount;
    }


    public LocalDateTime getCreateDate() {
        return createDate;
    }
    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }

    public LocalDateTime getLastUpdate() {
        return lastUpdate;
    }
    public void setLastUpdate(LocalDateTime lastUpdate) {
        this.lastUpdate = lastUpdate;
    }

    public MyPart getPart() {
        return part;
    }
    public void setPart(MyPart part) {
        this.part = part;
    }
}

