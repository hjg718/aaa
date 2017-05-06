package team.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import team.book.model.BookDao;
import team.book.model.BookVo;

@Service
public class BookService {

	@Autowired
	private SqlSessionTemplate sqlST;
	
	public List<BookVo> search(String keyword,String category){
		BookDao dao = sqlST.getMapper(BookDao.class);
		List<BookVo> list= dao.search(keyword,category);
		return list;
	}

	public boolean add(BookVo vo,HttpSession session) {
		BookDao dao = sqlST.getMapper(BookDao.class);
		MultipartFile file = vo.getCover();
		String[] name= file.getOriginalFilename().split("\\.");
		vo.setCoverName(name[1]);
		int row = dao.add(vo);
		if(row>0){
			for(int i=0;i<vo.getCate().size();i++){
				dao.addcate(vo.getBnum(),vo.getCate().get(i));
			}
			InputStream ins = null;
			OutputStream ous = null;
			try {
				ins = file.getInputStream();
				String coverName= vo.getBnum()+"."+name[1];
				File f = new File("D:/test/"+coverName);
				byte[] buf = new byte[1024];
				int read = 0;
				ous = new FileOutputStream(f);
				while((read=ins.read(buf))!=-1){
					ous.write(buf, 0, read);
					ous.flush();
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				try {
					ins.close();
					ous.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			return true;
		}
		return false;
	}

	public BookVo recent(int num) {
		BookDao dao = sqlST.getMapper(BookDao.class);
		BookVo book = dao.recent(num);
		List<String> cate= dao.getcate(num);
		book.setCate(cate);
		return book;
	}
}
