const requester = require('request-promise')
const details = require('./retrieveDetails')
const activity_url = process.env.ACTIVITY_URL

const activityType = {
    CREATE_USER: 0,
    UPDATE_USER: 1,
    DELETE_USER: 2,
    CREATE_STAGE: 3,
    UPDATE_STAGE: 4,
    DELETE_STAGE: 5,
    CREATE_RECEIPT: 6,
    UPDATE_RECEIPT: 7,
    DELETE_RECEIPT: 8,
    CREATE_PROJECT: 9,
    UPDATE_PROJECT: 10,
    DELETE_PROJECT: 11,
    CREATE_CLIENT: 12,
    UPDATE_CLIENT: 13,
    DELETE_CLIENT: 14,
    details: {
        0: { type: "User", action: "created" },
        1: { type: "User", action: "updated" },
        2: { type: "User", action: "deleted" },
        3: { type: "Stage", action: "created" },
        4: { type: "Stage", action: "updated" },
        5: { type: "Stage", action: "deleted" },
        6: { type: "Receipt", action: "created" },
        7: { type: "Receipt", action: "updated" },
        8: { type: "Receipt", action: "deleted" },
        9: { type: "Project", action: "created" },
        10: { type: "Project", action: "updated" },
        11: { type: "Project", action: "deleted" },
        12: { type: "Client", action: "created" },
        13: { type: "Client", action: "updated" },
        14: { type: "Client", action: "deleted" }
    }
}
module.exports = {

    activityType: activityType
    ,

    logActivity: async function (project_id, type_identifier, token, itemId) {

        itemId = (typeof itemId === undefined) ? -1 : itemId;

        if (project_id !== null && !isNaN(project_id) && !isNaN(itemId) && type_identifier !== null && token !== null) {

            const type = activityType.details[type_identifier].type
            const action = activityType.details[type_identifier].action
            const title = type + " " + action
            var options = {
                uri: activity_url,
                method: 'POST',
                headers: {
                    'token': token
                },
                form: {
                    project_id: project_id,
                    title: title,
                    type: type,
                },
                json: true
            }

            try {

                const performer = await details.getActionPerformerName(token)
                options.form.performer = performer
                if (type === "Client") {
                    const clientName = await details.getClientName(itemId)
                    options.form.description = type + " " + clientName + " was " + action + " by " + options.form.performer

                }

                else if (type === "User") {
                    const username = await details.getUsername(itemId)
                    options.form.description = type + " " + username + " was " + action + " by " + options.form.performer
                }

                else if (type === "Project") {
                    const projectName = await details.getProjectName(itemId)
                    options.form.description = type + " " + projectName + " was " + action + " by " + options.form.performer
                }
                else {
                    const projectName = await details.getProjectName(project_id)
                    options.form.description = description = type + " " + itemId + " was " + action + " by " + options.form.performer + " in project " + projectName

                }
            }
            catch (error) {
                console.log(error);
            }

            // Start the request
            await requester(options)
        }
    }
}