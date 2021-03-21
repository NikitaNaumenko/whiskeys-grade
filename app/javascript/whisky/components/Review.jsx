import React from 'react';
import { actions } from '../slices/index.js';
import { useSelector, useDispatch } from 'react-redux';

const Review = (props) => {
  const { review } = props;
  const { hexColorsMap }  = useSelector((state) => state);

  const renderColorBadge = (color) => {
    const style = { 'backgroundColor': hexColorsMap[color] }
    return(
      <span className='circle' style={style}></span>
    )
  }
  return(
    <div className='col my-3'>
      <div className='card'>
        <div className='card-header'>
          {review.user.email}
        </div>
        <div className='card-body'>
          <h5 className='card-title'>
           {review.summary}
         </h5>
         <p className='card-text'>
           {review.body}
           <br />
           <br />
           Taste: {review.taste}
           <br />
           <br />
           Smokiness: {review.smokiness} out of 5
           <br />
           <br />
           Color: {renderColorBadge(review.color)}
         </p>
        </div>
      </div>
    </div>
  )
}

export default Review;
