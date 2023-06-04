package myBean.part;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import jakarta.servlet.http.Part;

public class MyPart {
    private Part part;
    private String savedFileName;
    private String originalFileName;


    public MyPart(Part part, String realFolder) throws IOException{
        realFolder = "/Users/wibaek/Development/ClipClip/src/main/webapp/upload";
        this.part = part;
        originalFileName = part.getSubmittedFileName();

        if(originalFileName != null && originalFileName.length() != 0) {
            String fileDotExt = originalFileName.substring(originalFileName.lastIndexOf("."), originalFileName.length());
            UUID uuid = UUID.randomUUID();	//UUID: 범용 고유 식별자
            savedFileName = originalFileName.substring(0, originalFileName.lastIndexOf(".")) + "_" + uuid.toString() + fileDotExt;
            System.out.println(realFolder + File.separator + savedFileName);

            part.write(realFolder + File.separator + savedFileName);
        }
    }

    public Part getPart() {
        return part;
    }
    public String getSavedFileName() {
        return savedFileName;
    }
    public String getOriginalFileName() {
        return originalFileName;
    }
}