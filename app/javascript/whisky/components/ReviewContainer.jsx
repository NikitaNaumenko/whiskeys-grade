import React from 'react';
import ReviewForm from './ReviewForm';
import Reviews from './Reviews'

const ReviewContainer = () => {
  return(
    <div className='container'>
      <div className='row justify-content-center'>
        <div className='col-12 col-lg-10'>
          <ReviewForm />
          <div className='mt-3'>
            <Reviews />
          </div>
        </div>
      </div>
    </div>
  )
}

export default ReviewContainer;
