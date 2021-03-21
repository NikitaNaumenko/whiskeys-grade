import React from 'react';
import Review from './Review'
import { actions } from '../slices/index.js';
import { useSelector, useDispatch } from 'react-redux';

const Reviews = () => {
  const { reviews } = useSelector((state) => state);

  return(
    reviews.map((review) => <Review key={review.id} review={review}/>)
  )

}

export default Reviews;
// .col
//   .card
//     .card-header
//       = review.user.email
//     .card-body
//       h5.card-title
//         / = review.summary
//         great!
//       p.card-text
//         = review.body
//     .card-footer
//       small.text-muted
//         = l(review.created_at, format: :long)
