import _ from 'lodash';

export const mergeBelongsToForRecords = (records) => {
  const { data, included } = records;

  return data.map((record) => mergeBelongsToForRecord(record, included))
}

export const mergeBelongsToForRecord = (record, included) => {
    const { attributes, relationships } = record
    const processedRelationships = Object.values(relationships).map((object) => object.data)
    const belongedRecords = _.unionBy(included, processedRelationships, 'id, type')

    const attrs = record.attributes
    belongedRecords.forEach((r) => attrs[r.type] = r.attributes)

    return attrs
}
