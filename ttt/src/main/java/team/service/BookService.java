package team.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


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
}
