import React, { useEffect, useState } from 'react';
import { CirclePicker } from 'react-color';
import _ from 'lodash';
import { actions } from '../slices/index.js';
import { useSelector, useDispatch } from 'react-redux';


const ReviewForm = () => {
  const dispatch = useDispatch();
  const { whisky, review, hexColorsMap, tastes, errors } = useSelector((state) => state);

  const renderErrors = (errors) => {
    if (_.isEmpty(errors)) { return null; }
    const buildMessage = (key, value) => [_.capitalize(key), value].join(': ');

    return(
      <div className="alert alert-danger">
      {Object.entries(errors).map(([key, value]) => <p key={key}>{buildMessage(key, value)}</p>)}
      </div>
    )
  }
  const colors = Object.values(hexColorsMap)
  const handleChangeBody = (e) => {
    dispatch(actions.changeBody({ reviewBody: e.target.value }))
  }
  const handleChangeSummary = (e) => {
    dispatch(actions.changeSummary({ summary: e.target.value }))
  }
  const handleChangeColor = (e) => {
    dispatch(actions.changeColor({ color: e.hex }))
  }
  const handleChangeTaste = (e) => {
    dispatch(actions.changeTaste({ taste: e.target.value }))
  }
  const handleChangeSmokiness = (e) => {
    dispatch(actions.changeSmokiness({ smokiness: e.target.value }))
  }

  const handleSubmit = (e) => {
    e.preventDefault()

    dispatch(actions.sendReview(whisky, review))
  }
  const tasteOptions = Object.entries(tastes).map(([key, value]) => <option key={value} value={value}>{key}</option>)

  return(
        <div className='col-sm-8 col-md-7 col-lg-6'>
          <div className='card'>
            <div className='card-body p-4'>
              <form onSubmit={handleSubmit}>
                <p className='text-center'>{`Write your review about ${whisky.full_name}`}</p>
                {renderErrors(errors)}
                <div className='form-group my-2'>
                  <label className='form-label' htmlFor='summary'>
                    Summary:
                  </label>
                  <input className="form-control"
                         id='summary'
                         value={review.summary}
                         onChange={handleChangeSummary}/>
                </div>
                <div className='form-group my-2'>
                  <label className='form-label' htmlFor='body'>
                    Body:
                  </label>
                  <textarea id='body'
                            className="form-control"
                            value={review.body}
                            onChange={handleChangeBody}/>
                </div>
                <div className='form-group my-2'>
                  <select className="form-select" value={review.taste} onChange={handleChangeTaste}>
                    {tasteOptions}
                  </select>
                </div>
                <div className='form-group my-2'>
                  <label className='form-label'>Color:</label>
                  <CirclePicker colors={colors} width={'85%'} onChange={handleChangeColor}/>
                </div>
                <div className='form-group my-2'>
                  <label className='form-label' htmlFor='smokiness'>Smokiness:</label>
                  <input
                    type="range"
                    className="form-range"
                    id="smokiness"
                    value={review.smokiness}
                    min={0}
                    max={5}
                    onChange={handleChangeSmokiness}/>
                </div>
                <div className='form-group my-2'>
                  <input type="submit" value="Submit" className="btn btn-primary"/>
                </div>
              </form>
            </div>
        </div>
      </div>
  )
}

export default ReviewForm;
