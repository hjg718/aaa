package team.book.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BookDao {

	public List<BookVo> search(@Param("keyword")String keyword,@Param("category")String category);

	public int add(BookVo vo);

	public void addcate(@Param("num") int num,@Param("cate") String string);

	public BookVo recent(int num);

	public List<String> getcate(int num);
	
}
