package cqu.demo;

import java.net.*;
import cqu.ioc.annotation.Controller;
import cqu.ioc.annotation.RequestMapping;
import cqu.mvc.model.FileDao;
import cqu.mvc.model.FileEntity;
import cqu.mvc.model.UserDao;
import cqu.mvc.model.UserEntity;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;



/**
 * 处理展示文件和上传文件的控制类
 */
@Controller
@RequestMapping("/disk")
public class DiskController {

    @RequestMapping(value = "/show", method = "GET")
    public String showGET(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Cookie []cookies = req.getCookies();
        boolean flag = false;
        String username = "";
        for (Cookie cookie:cookies){
            if (cookie.getName().equals("uploader")) {
                flag = true;
                username = cookie.getValue();
                break;
            }
        }
        if(!flag) return "redirect:http://localhost:8080/SpringMVC/user/login";
        List<FileEntity> fileEntityList = FileDao.getFileByUser(username);
        System.out.println("fileEntityList: "+fileEntityList);
        List<String> fileNameList = new ArrayList<>();
        for (FileEntity fileEntity:
             fileEntityList) {
            fileNameList.add(fileEntity.getName());
        }
        System.out.println("fileNameList: "+fileNameList);
        req.setAttribute("Files",fileNameList);
        return "disk";
    }

    @RequestMapping(value = "/upload", method = "POST")
    public String uploadPOST(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Cookie []cookies = req.getCookies();
        boolean flag = false;
        String username = "";
        for (Cookie cookie:cookies){
            if (cookie.getName().equals("uploader")) {
                flag = true;
                username = cookie.getValue();
                break;
            }
        }
        if(!flag)
            return "redirect:http://localhost:8080/SpringMVC/user/login";
        String fileName=null;
        try {

            Part part= req.getPart("file");
            String fileHeader=part.getHeader("content-disposition");
            fileName=fileHeader.substring(fileHeader.indexOf("filename=")+10, fileHeader.lastIndexOf("\""));
            fileName=fileName.replace(' ','_');
            String classpath = Objects.requireNonNull(Thread.currentThread().getContextClassLoader().getResource("/")).getPath();
            String filepath = classpath.replace("WEB-INF/classes", "WEB-INF/file");
            String usrpath = classpath.replace("WEB-INF/classes", "WEB-INF/file/" + username);
            File dir = new File(filepath);
            File usrdir = new File(usrpath);
            if (!dir.exists()) dir.mkdir();
            if (!usrdir.exists()) usrdir.mkdir();
            part.write(usrpath + File.separator + fileName);
            FileDao.addFile(username+fileName,fileName,UserDao.getUserByName(username));
        }catch (Exception e){
            e.printStackTrace();
        }

        return "redirect:http://localhost:8080/SpringMVC/disk/show";

    }
    
    @RequestMapping(value = "/download", method = "GET")
    public String downloadGET(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Cookie []cookies = req.getCookies();
        boolean flag = false;
        String username = "";
        for (Cookie cookie:cookies){
            if (cookie.getName().equals("uploader")) {
                flag = true;
                username = cookie.getValue();
                break;
            }
        }
        if(!flag) return "redirect:http://localhost:8080/SpringMVC/user/login";
        List<FileEntity> fileEntityList = FileDao.getFileByUser(username);
        System.out.println("fileEntityList: "+fileEntityList);
        List<String> fileNameList = new ArrayList<>();
        List<String> downurl = new ArrayList<>();
        
        for (FileEntity fileEntity:
             fileEntityList) {
            fileNameList.add(fileEntity.getName());
        }
        
        System.out.println("fileNameList: "+fileNameList);
        req.setAttribute("Files",fileNameList);
        return "download";
    }
    @RequestMapping(value = "/load", method = "GET")
    public String loadGET(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Cookie []cookies = req.getCookies();
        boolean flag = false;
        String username = "";
        for (Cookie cookie:cookies){
            if (cookie.getName().equals("uploader")) {
                flag = true;
                username = cookie.getValue();
                break;
            }
        }
        if(!flag) {return "redirect:http://localhost:8080/SpringMVC/user/login";}
        String filename = req.getParameter("filename");
        filename = new String(filename.getBytes("iso8859-1"),"UTF-8");
        System.out.println("user: "+username);
        String classpath = req.getSession().getServletContext().getRealPath("/WEB-INF/file/"+username);
        String path = classpath;
        //System.out.println("path: "+path);
        File file = new File(path + "\\" + filename);
        System.out.println("path: "+path + "\\" + filename);
        //如果文件不存在
        if(!file.exists()) {
        	return "redirect:http://localhost:8080/SpringMVC/disk/show";
        }
        //处理文件名
        String realname = ((String) filename).substring(((String) filename).indexOf("_")+1);
        System.out.println("realname:"+realname);
        //设置响应头，控制浏览器下载该文件
        res.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(realname, "UTF-8"));
        //读取要下载的文件，保存到文件输入流
        FileInputStream in = new FileInputStream(path + "\\" + filename);
        //创建输出流
        OutputStream out = res.getOutputStream();
        //创建缓冲区
        byte buffer[] = new byte[1024];
        int len = 0;
        //循环将输入流中的内容读取到缓冲区当中
        while((len=in.read(buffer))>0){
            //输出缓冲区的内容到浏览器，实现文件下载
        	out.write(buffer, 0, len);
        }
        //关闭文件输入流
        in.close();
        //关闭输出流
        out.close();
        return "redirect:http://localhost:8080/SpringMVC/disk/download";
    }
    @RequestMapping(value = "/delete", method = "GET")
    public String deleteGET(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Cookie []cookies = req.getCookies();
        boolean flag = false;
        String username = "";
        for (Cookie cookie:cookies){
            if (cookie.getName().equals("uploader")) {
                flag = true;
                username = cookie.getValue();
                break;
            }
        }
        if(!flag) {return "redirect:http://localhost:8080/SpringMVC/user/login";}
        String filename = req.getParameter("filename");
        filename = new String(filename.getBytes("iso8859-1"),"UTF-8");
        System.out.println("user: "+username);
        String classpath = req.getSession().getServletContext().getRealPath("/WEB-INF/file/"+username);
        String path = classpath;
        //System.out.println("path: "+path);
        File file = new File(path + "\\" + filename);
        System.out.println("path: "+path + "\\" + filename);
        //如果文件不存在
        if(!file.exists()) {
        	return "redirect:http://localhost:8080/SpringMVC/disk/show";
        }
        //处理文件名
        String realname = ((String) filename).substring(((String) filename).indexOf("_")+1);
        System.out.println("realname:"+realname);
        if (file.delete()) {
        	System.out.println("Deleted the file: " + file.getName());

        } else {
        	System.out.println("Failed to delete the file.");
        }
        String id = username+filename;
        System.out.println("id: "+id);
        if(FileDao.getFileById(id).getId().equals(id) && FileDao.getFileById(id).getName().equals(filename) && FileDao.getFileById(id).getUser().getName().equals(username)) {
            FileDao.Del(id, filename, UserDao.getUserByName(username));
        }
        return "redirect:http://localhost:8080/SpringMVC/disk/download";
    }
    @RequestMapping(value = "/share", method = "GET")
    public String shareGET(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Cookie []cookies = req.getCookies();
        boolean flag = false;
        String username = "";
        for (Cookie cookie:cookies){
            if (cookie.getName().equals("uploader")) {
                flag = true;
                username = cookie.getValue();
                break;
            }
        }
        if(!flag) return "redirect:http://localhost:8080/SpringMVC/user/login";
        List<FileEntity> fileEntityList = FileDao.getFileByUser(username);
        System.out.println("fileEntityList: "+fileEntityList);
        List<String> fileNameList = new ArrayList<>();
        for (FileEntity fileEntity:
             fileEntityList) {
            fileNameList.add(fileEntity.getName());
        }
        System.out.println("fileNameList: "+fileNameList);
        req.setAttribute("Files",fileNameList);
        return "share";
    }

    @RequestMapping(value = "/shared", method = "POST")
    public String sharedPOST(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        Cookie []cookies = req.getCookies();
        boolean flag = false;
        String username = "";
        for (Cookie cookie:cookies){
            if (cookie.getName().equals("uploader")) {
                flag = true;
                username = cookie.getValue();
                break;
            }
        }
        if(!flag)
            return "redirect:http://localhost:8080/SpringMVC/user/login";
        String fileName=null;
        try {
        	String username2 = req.getParameter("username2");
            Part part= req.getPart("file");
            if(UserDao.getUserByName(username2) == null || username2 == username || part == null) {
            	return "redirect:http://localhost:8080/SpringMVC/disk/show";
            }
            String fileHeader=part.getHeader("content-disposition");
            fileName=fileHeader.substring(fileHeader.indexOf("filename=")+10, fileHeader.lastIndexOf("\""));
            fileName=fileName.replace(' ','_');
            String classpath = Objects.requireNonNull(Thread.currentThread().getContextClassLoader().getResource("/")).getPath();
            String filepath = classpath.replace("WEB-INF/classes", "WEB-INF/file");
            String usrpath = classpath.replace("WEB-INF/classes", "WEB-INF/file/" + username2);
            File dir = new File(filepath);
            File usrdir = new File(usrpath);
            if (!dir.exists()) dir.mkdir();
            if (!usrdir.exists()) usrdir.mkdir();
            part.write(usrpath + File.separator + fileName);
            FileDao.addFile(username2+fileName,fileName,UserDao.getUserByName(username2));
        }catch (Exception e){
            e.printStackTrace();
        }

        return "redirect:http://localhost:8080/SpringMVC/disk/share";

    }
}