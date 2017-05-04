package team.book.model;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BookDao {

	public List<BookVo> search(@Param("keyword")String keyword,@Param("category")String category);
	
}
